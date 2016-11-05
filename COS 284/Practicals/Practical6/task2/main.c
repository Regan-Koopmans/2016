#include <stdlib.h>
#include <stdio.h>

struct Node
{
	char* id;
	struct Link
	{
		struct Node* neighbour;
		double distance;
	}* links;
	size_t nrOfLinks;
	struct Route
	{
		struct Node* target;
		double totalDistance;
		struct Node* nextHop;
	}* routes;
	size_t nrOfRoutes;
};

extern void calculateRoutes(struct Node*);

int main()
{
	struct Node* nodeA = malloc(sizeof(struct Node));
	struct Node* nodeB = malloc(sizeof(struct Node));
	struct Node* nodeC = malloc(sizeof(struct Node));
	struct Node* nodeD = malloc(sizeof(struct Node));

	nodeA->id = "Node A";
	nodeB->id = "Node B";
	nodeC->id = "Node C";
	nodeD->id = "Node D";

	nodeA->links = malloc(sizeof(struct Link)*3);
	nodeA->links[0].neighbour = nodeB;
	nodeA->links[0].distance = 5.4;
	nodeA->links[1].neighbour = nodeC;
	nodeA->links[1].distance = 2.1;
	nodeA->links[2].neighbour = nodeD;
	nodeA->links[2].distance = 3.3;
	nodeA->nrOfLinks = 3;
	nodeA->routes = 0;
	nodeA->nrOfRoutes = 0;

	nodeB->links = malloc(sizeof(struct Link)*2);
	nodeB->links[0].neighbour = nodeA;
	nodeB->links[0].distance = 5.4;
	nodeB->links[1].neighbour = nodeC;
	nodeB->links[1].distance = 1.2;
	nodeB->nrOfLinks = 2;
	nodeB->routes = 0;
	nodeB->nrOfRoutes = 0;

	nodeC->links = malloc(sizeof(struct Link)*2);
	nodeC->links[0].neighbour = nodeB;
	nodeC->links[0].distance = 1.2;
	nodeC->links[1].neighbour = nodeA;
	nodeC->links[1].distance = 2.1;
	nodeC->nrOfLinks = 2;
	nodeC->routes = 0;
	nodeC->nrOfRoutes = 0;

	nodeD->links = malloc(sizeof(struct Link)*1);
	nodeD->links[0].neighbour = nodeA;
	nodeD->links[0].distance = 3.3;
	nodeD->nrOfLinks = 1;
	nodeD->routes = 0;
	nodeD->nrOfRoutes = 0;

	calculateRoutes(nodeC);
	calculateRoutes(nodeD);

	for (size_t i = 0; i < nodeA->nrOfRoutes; i++)
	{
		printf(nodeA->routes[i].target->id);
		printf(" ");
		printf(nodeA->routes[i].nextHop->id);
		printf(" %.1f ", nodeA->routes[i].totalDistance);
		printf("\n");
	}
	printf("\n");
	for (size_t i = 0; i < nodeB->nrOfRoutes; i++)
	{
		printf(nodeB->routes[i].target->id);
		printf(" ");
		printf(nodeB->routes[i].nextHop->id);
		printf(" %.1f ", nodeB->routes[i].totalDistance);
		printf("\n");
	}
	printf("\n");
	for (size_t i = 0; i < nodeC->nrOfRoutes; i++)
	{
		printf(nodeC->routes[i].target->id);
		printf(" ");
		printf(nodeC->routes[i].nextHop->id);
		printf(" %.1f ", nodeC->routes[i].totalDistance);
		printf("\n");
	}
	printf("\n");
	for (size_t i = 0; i < nodeD->nrOfRoutes; i++)
	{
		printf(nodeD->routes[i].target->id);
		printf(" ");
		printf(nodeD->routes[i].nextHop->id);
		printf(" %.1f ", nodeD->routes[i].totalDistance);
		printf("\n");
	}
	printf("\n");

	free(nodeD->routes);
	free(nodeD->links);
	free(nodeD);
	free(nodeC->routes);
	free(nodeC->links);
	free(nodeC);
	free(nodeB->routes);
	free(nodeB->links);
	free(nodeB);
	free(nodeA->routes);
	free(nodeA->links);
	free(nodeA);
}
